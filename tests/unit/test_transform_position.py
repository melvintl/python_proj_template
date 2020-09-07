"""
This is a test
"""
from src.transform import position

# from src import main

from src.main import transform_position_handler


def test_foo1():
    position.do_transform()
    assert 5 == 5


def test_transform_position_handler():
    transform_position_handler("", "")
    assert 1 == 1
