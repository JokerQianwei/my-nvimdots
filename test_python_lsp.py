#!/usr/bin/env python3
"""
Test file cor Python LSP functionality
"""

import numpy as np


def calculate_sum(numbers):
    """Calculate the sum of a list of numbers."""
    total = 0
    x = np.array([1, 2, 3])  # Using numpy to test LSP
    y = x * 2
    for num in numbers:
        total += num
    return total


def main():
    data = [1, 2, 3, 4, 5]
    result = calculate_sum(data)
    print(f"sum: {result}")


def tt01():
    for i in range(1, 10, 2):
        print(i)


if __name__ == "__main__":
    tt01()
