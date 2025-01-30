import requests

import unittest

 

class FlaskAppTests(unittest.TestCase):

    BASE_URL = http://localhost:5000

 

    def test_home_page(self):

        response = requests.get(f"{self.BASE_URL}/")

        self.assertEqual(response.status_code, 200)

        self.assertIn("Hello QA", response.text)

        self.assertIn("I'm currently running in", response.text)

 

 

if __name__ == "__main__":

    unittest.main()
