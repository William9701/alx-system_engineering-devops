#!/usr/bin/python3
""" This is an andvanced api setup """

from collections import Counter
import re
import requests


def count_words(subreddit, word_list, after=None, word_count=None):
    headers = {'User-Agent': 'my-app/0.0.1'}
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"

    if after:
        url += f"?after={after}"

    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code != 200:
        return

    if word_count is None:
        word_count = Counter()

    data = response.json()
    posts = data['data']['children']
    for post in posts:
        title = post['data']['title']
        title_words = re.findall(r'\b\w+\b', title.lower())
        for word in word_list:
            word_count[word] += title_words.count(word.lower())

    after = data['data']['after']

    if after is None:
        sorted_word_count = sorted([(k, v) for k, v in word_count.items()
                                   if v > 0], key=lambda x: (-x[1], x[0]))
        for word, count in sorted_word_count:
            print(f"{word}: {count}")
    else:
        count_words(subreddit, word_list, after, word_count)
