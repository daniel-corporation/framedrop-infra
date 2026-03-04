import json
import smtplib
import ssl
import os
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

SMTP_HOST = os.environ.get('SMTP_HOST', 'smtp.gmail.com')
SMTP_PORT = int(os.environ.get('SMTP_PORT', '465'))
SMTP_APP_TOKEN = os.environ.get('SMTP_APP_TOKEN')
SENDER_EMAIL = os.environ.get('SENDER_EMAIL', 'noreply@framedrop.com')


def send_email_smtp(to_email, subject, body):
    """
    Envia e-mail via SMTP com SSL/TLS na porta 465.
    """
    msg = MIMEMultipart()
    msg['From'] = SENDER_EMAIL
    msg['To'] = to_email
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain', 'utf-8'))

    context = ssl.create_default_context()

    with smtplib.SMTP_SSL(SMTP_HOST, SMTP_PORT, context=context) as server:
        server.login(SENDER_EMAIL, SMTP_APP_TOKEN)
        server.sendmail(SENDER_EMAIL, to_email, msg.as_string())

    print(f"E-mail enviado para {to_email} via SMTP SSL (porta {SMTP_PORT})")


def lambda_handler(event, context):
    """
    Função Lambda para processar eventos do DynamoDB Stream.
    Envia e-mail via SMTP SSL/TLS para o usuário quando o statusProcess é alterado.
    """
    print(f"Evento recebido: {json.dumps(event)}")

    for record in event['Records']:
        # Processar apenas INSERT e MODIFY
        if record['eventName'] in ['INSERT', 'MODIFY']:
            new_image = record['dynamodb'].get('NewImage', {})
            old_image = record['dynamodb'].get('OldImage', {})

            # Verificar se o campo statusProcess mudou
            new_status = new_image.get('statusProcess', {}).get('S')
            old_status = old_image.get('statusProcess', {}).get('S') if old_image else None

            # Se o status mudou ou é um novo registro com status
            if new_status and new_status != old_status:
                # Obter email do usuário
                user_email = new_image.get('email', {}).get('S')
                video_id = new_image.get('videoId', {}).get('S')
                url_pre_signed = new_image.get('urlPreSigned', {}).get('S')

                if not user_email:
                    print(f"Email não encontrado para o registro: {video_id}")
                    continue

                # Preparar bloco de download se houver URL
                download_section = ""
                if url_pre_signed:
                    download_section = f"\nFaça o download dos frames:\n{url_pre_signed}\n"

                # Preparar mensagem
                email_body = f"""Olá!

O status do seu processo foi atualizado:

Video ID: {video_id}
Status Anterior: {old_status if old_status else 'Novo'}
Status Atual: {new_status}
{download_section}
Este é um e-mail automático de notificação.

Atenciosamente,
Sistema FrameDrop"""

                subject = f"Atualização de Status - {new_status}"

                # Enviar e-mail via SMTP SSL/TLS
                try:
                    send_email_smtp(user_email, subject, email_body)
                except Exception as e:
                    print(f"Erro ao enviar e-mail: {str(e)}")
                    raise

    return {
        'statusCode': 200,
        'body': json.dumps('Processamento concluído')
    }
