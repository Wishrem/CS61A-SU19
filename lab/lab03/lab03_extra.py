""" Optional problems for Lab 3 """


def is_prime(n):
    """Returns True if n is a prime number and False otherwise.

    >>> is_prime(2)
    True
    >>> is_prime(16)
    False
    >>> is_prime(521)
    True
    """
    "*** YOUR CODE HERE ***"
    def helper(n, x, end):
        if x > end:
            return True
        if n % x == 0:
            return False
        return helper(n, x+1, end)
    return helper(n, 2, n-1)


def gcd(a, b):
    """Returns the greatest common divisor of a and b.
    Should be implemented using recursion.

    >>> gcd(34, 19)
    1
    >>> gcd(39, 91)
    13
    >>> gcd(20, 30)
    10
    >>> gcd(40, 40)
    40
    """
    "*** YOUR CODE HERE ***"
    _min = min(a, b)
    _max = max(a, b)
    if _max % _min == 0:
        return _min
    else:
        return gcd(_min, _max % _min)


def ten_pairs(n):
    """Return the number of ten-pairs within positive integer n.

    >>> ten_pairs(7823952)
    3
    >>> ten_pairs(55055)
    6
    >>> ten_pairs(9641469)
    6
    """
    "*** YOUR CODE HERE ***"
    def get_num_digits(x, n):
        if n < 10:
            return 1 if x == n else 0
        else:
            return 1 + get_num_digits(x, n//10) if x == n % 10 else get_num_digits(x, n//10)

    if n < 10:
        return 0
    return get_num_digits(10 - n % 10, n//10) + ten_pairs(n//10)
