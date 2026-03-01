import json
import boto3
import os

ses_client = boto3.client('ses', region_name='us-east-1')
SENDER_EMAIL = os.environ.get('SENDER_EMAIL', 'noreply@framedrop.com')

def lambda_handler(event, context):
    """
    Função Lambda para processar eventos do DynamoDB Stream.
    Envia e-mail via SES diretamente para o usuário quando o statusProcess é alterado.
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
                
                if not user_email:
                    print(f"Email não encontrado para o registro: {video_id}")
                    continue
                
                # Preparar mensagem
                email_body = f"""Olá!

O status do seu processo foi atualizado:

Video ID: {video_id}
Status Anterior: {old_status if old_status else 'Novo'}
Status Atual: {new_status}

Este é um e-mail automático de notificação.

Atenciosamente,
Sistema FrameDrop"""
                
                subject = f"Atualização de Status - {new_status}"
                
                # Enviar e-mail via SES diretamente para o usuário
                try:
                    response = ses_client.send_email(
                        Source=SENDER_EMAIL,
                        Destination={
                            'ToAddresses': [user_email]
                        },
                        Message={
                            'Subject': {
                                'Data': subject,
                                'Charset': 'UTF-8'
                            },
                            'Body': {
                                'Text': {
                                    'Data': email_body,
                                    'Charset': 'UTF-8'
                                }
                            }
                        }
                    )
                    
                    print(f"E-mail enviado para {user_email}. MessageId: {response['MessageId']}")
                    
                except Exception as e:
                    print(f"Erro ao enviar e-mail: {str(e)}")
                    raise
    
    return {
        'statusCode': 200,
        'body': json.dumps('Processamento concluído')
    }
