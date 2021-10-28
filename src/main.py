
from aws_lambda_powertools import Logger, Tracer
from aws_lambda_powertools.logging import correlation_paths
from aws_lambda_powertools.event_handler.api_gateway import ApiGatewayResolver
from aws_lambda_powertools.utilities.typing import LambdaContext

tracer = Tracer()
logger = Logger()
api = ApiGatewayResolver()  # default API Gateway REST API (v1)


#
# Basic lambda entrypoint
#

@logger.inject_lambda_context
def lambda_handler(event: dict, context: LambdaContext):
    """ echos basck input """
    return event


#
# API-GW routes
#

@api.get("/health-check")
@tracer.capture_method
def health_check():
    """ return current status """
    return {"status": "OK"}


@api.post("/echo")
def echo():
    """ echo back body """
    body: dict = api.current_event.json_body
    return body


#
# API-GW lambda entrypoint
#

@logger.inject_lambda_context(correlation_id_path=correlation_paths.API_GATEWAY_REST)
@tracer.capture_lambda_handler
def api_gw_lambda_handler(event, context: LambdaContext):
    """ routes to specific paths """
    return api.resolve(event, context)
