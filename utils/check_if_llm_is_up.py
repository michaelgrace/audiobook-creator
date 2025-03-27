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
import requests

def check_if_llm_is_up(openai_client, model_name):
    try:
        # Convert the URL object to string and remove the /v1
        base_url_str = str(openai_client.base_url)
        base_url = base_url_str.replace('/v1', '')
        
        response = requests.get(f"{base_url}/health")
        
        if response.status_code == 200:
            return True, "Kokoro service is up and running"
        else:
            return False, f"Kokoro service returned status code {response.status_code}"
            
    except Exception as e:
        traceback.print_exc()
        return False, "Your configured LLM is not working. Please check if the .env file is correctly set up. Error: " + str(e)