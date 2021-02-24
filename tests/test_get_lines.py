#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import unittest

from maccyakto import get_lines


class TestGetLines(unittest.TestCase):
    def test_get_lines_of_min_length(self):
        text = """\
first line
   second line with whitespace
short"""
        words = [
            "first line",
            "second line with whitespace",
        ]

        result = get_lines(text, min_length=6)
        self.assertEqual(words, result)


if __name__ == "__main__":
    unittest.main()
