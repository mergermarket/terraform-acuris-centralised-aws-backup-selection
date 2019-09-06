import sys, io
import unittest
import get_plan_id

class TestGetPlanId(unittest.TestCase):

    def test_read_in(self):
        input = io.StringIO('{"test":"12345"}')
        result = get_plan_id.read_in(input)
        self.assertEqual(result, {"test":"12345"})

    def test_main(self):
        input = io.StringIO('{"plan_name":"daily_expire_28_days"}')
        output = io.StringIO()
        get_plan_id.main(input, output)
        output.seek(0)
        self.assertEqual(output.read(), '{"plan_id": "93640b53-1be7-4c16-81d2-987c2f218ddd"}')
