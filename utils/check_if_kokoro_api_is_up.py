"""
Audiobook Creator
Copyright (C) 2025 Prakhar Sharma

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
"""

import traceback
import openai  # Add this import

def check_if_kokoro_api_is_up(client):
    try:
        # Try with the specified model first
        with client.audio.speech.with_streaming_response.create(
            model="kokoro",
            voice="af_heart",
            response_format="aac",
            speed=0.85,
            input="Hello, how are you?"
        ) as response:
            return True, None
    except openai.NotFoundError:
        # If the model is not found, log the specific error
        traceback.print_exc()
        return False, "The Kokoro model was not found. This model may not exist or your account may not have access to it."
    except Exception as e:
        traceback.print_exc()
        return False, "The Kokoro API is not working. Please check if the .env file is correctly set up and the API is up. Error: " + str(e)