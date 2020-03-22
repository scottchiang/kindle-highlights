import email
from bs4 import BeautifulSoup
import boto3
import base64
import os
from boto3.dynamodb.conditions import Key

table_name = os.environ['TABLE_NAME']

def handler(event, context):
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    s3_client = boto3.client('s3')
    body = s3_client.get_object(Bucket=bucket, Key=key)['Body'].read()

    payload = email.message_from_bytes(body)
    attachment = payload.get_payload()[1].get_payload(decode=True)
    soup = BeautifulSoup(attachment, 'html.parser')

    dynamodb = boto3.resource('dynamodb', region_name='us-west-2')
    table = dynamodb.Table(table_name)
    title = soup.find('div', {'class': 'bookTitle'}).text.strip()
    print(title)

    for highlight in soup.find_all('div', {'class': 'noteText'}):
        text = highlight.text.strip()
        encoded_bytes = base64.b64encode(text.encode("utf-8"))
        encoded_str = str(encoded_bytes, "utf-8")

        query = table.query(
            KeyConditionExpression=Key('id').eq(encoded_str) & Key('title').eq(title)
        )

        if query['Count'] > 0:
            continue

        table.put_item(
            Item={
                'title': title,
                'id': encoded_str,
                'text': text
            }
        )
