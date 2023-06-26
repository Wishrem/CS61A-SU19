""" Typing Test implementation """

from utils import *
from ucb import main

# BEGIN Q1-5
"*** YOUR CODE HERE ***"


def lines_from_file(path):
    file = open(path)
    lst = []
    s = readline(file)
    while s != "":
        lst.append(strip(s, '\n\t '))
        s = readline(file)
    return lst


def new_sample(path, i):
    assert i >= 0
    return lines_from_file(path)[i]


def analyze(sample_paragraph, typed_string, start_time, end_time):
    tot_time = end_time - start_time  # seconds
    sample_words = split(sample_paragraph)
    typed_words = split(typed_string)
    return [worlds_per_minute(len(typed_string)/5, tot_time), typed_accuracy(sample_words, typed_words)]


def worlds_per_minute(num, seconds):
    return num / seconds * 60


def typed_accuracy(sample_words, typed_words):
    n = min(len(typed_words), len(sample_words))
    if n == 0:
        return 0.
    cnt = 0
    for i in range(n):
        if sample_words[i] == typed_words[i]:
            cnt += 1
    return cnt/n*100


def pig_latin(word):
    lst = split_word(word)
    if begin_with_vowel(lst):
        return rule2(lst)
    else:
        return rule1(lst)


def rule1(lst):
    return lst[1] + lst[0] + 'ay'


def rule2(lst):
    return lst[1] + 'way'


def begin_with_vowel(lst):
    return lst[0] == ''


def split_word(word):
    vowel = 'aeiou'
    head = ''
    for c in word:
        if c in vowel:
            break
        head += c
    return [head, word[len(head):]] if head != word else [word, '']


def autocorrect(user_input, words_list, score_function):
    if user_input in words_list:
        return user_input
    return min(words_list, key=lambda w: score_function(user_input, w))


def swap_score(word1, word2):
    if not word1 or not word2:
        return 0
    return (word1[0] != word2[0]) + swap_score(word1[1:], word2[1:])
# END Q1-5

# Question 6


def score_function(word1, word2):
    """A score_function that computes the edit distance between word1 and word2."""

    if not word1 or not word2 or \
            word1 in word2 or \
            word2 in word1:  # Fill in the condition
        # BEGIN Q6
        "*** YOUR CODE HERE ***"
        # the fist line condition represents one of two words is longer than the other
        # the second line and the third one represent one of two words is included in the other
        # either of these condition is true, it means we need just to add some characters
        # so that we can make the two word same.
        return abs(len(word1) - len(word2))
        # END Q6

    elif word1[0] == word2[0]:  # Feel free to remove or add additional cases
        # BEGIN Q6
        "*** YOUR CODE HERE ***"
        return score_function(word1[1:], word2[1:])
        # END Q6

    else:
        # Fill in these lines
        # we only manipulate the first word.
        # if you feel like manipulating the second word, that is fine too.
        add_char = 1 + score_function(word2[0] + word1, word2)
        remove_char = 1 + score_function(word1[1:], word2)
        # substituting a character is similar to remove the character
        substitute_char = 1 + score_function(word1[1:], word2[1:])
        # BEGIN Q6
        "*** YOUR CODE HERE ***"
        return min(add_char, remove_char, substitute_char)
        # END Q6


KEY_DISTANCES = get_key_distances()

# BEGIN Q7-8
"*** YOUR CODE HERE ***"


def score_function_accurate(word1, word2):
    if not word1 or not word2 or \
            word1 in word2 or \
            word2 in word1:
        return abs(len(word1) - len(word2))

    elif word1[0] == word2[0]:
        return score_function_accurate(word1[1:], word2[1:])
    else:
        add_char = 1 + score_function_accurate(word2[0] + word1, word2)
        remove_char = 1 + score_function_accurate(word1[1:], word2)
        substitute_char = (KEY_DISTANCES[word1[0], word2[0]]
                           + score_function_accurate(word1[1:], word2[1:]))
        return min(add_char, remove_char, substitute_char)


def memorize(fn):
    cache = dict()

    def wrapper(*args):
        if args in cache:
            return cache[args]
        result = fn(*args)
        cache[args] = result
        return result
    return wrapper


@memorize
def score_function_final(word1, word2):
    if not word1 or not word2 or \
            word1 in word2 or \
            word2 in word1:
        return abs(len(word1) - len(word2))

    elif word1[0] == word2[0]:
        return score_function_final(word1[1:], word2[1:])
    else:
        add_char = 1 + score_function_final(word2[0] + word1, word2)
        remove_char = 1 + score_function_final(word1[1:], word2)
        substitute_char = (KEY_DISTANCES[word1[0], word2[0]]
                           + score_function_final(word1[1:], word2[1:]))
        return min(add_char, remove_char, substitute_char)

# END Q7-8
