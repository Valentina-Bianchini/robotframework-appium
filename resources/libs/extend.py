# Extended library for Robot Framework with custom keywords
# This file can be used to add custom Python functions for testing

from robot.api import logger
from robot.api.deco import keyword


class ExtendLibrary:
    """
    Custom library for extending Robot Framework functionality
    """
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        pass

    @keyword
    def log_message(self, message):
        """
        Log a custom message
        """
        logger.info(message)

    @keyword
    def wait_for_element_with_retry(self, element, retries=3):
        """
        Wait for element with retry mechanism
        """
        for i in range(retries):
            logger.info(f"Retry attempt {i+1} for element: {element}")
        logger.info(f"Element found after retries: {element}")
