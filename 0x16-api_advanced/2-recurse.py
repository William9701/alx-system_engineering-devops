#!/usr/bin/python3
""" This is and andvanced api stup that retrives the data recusivley"""
import requests


def recurse(subreddit, hot_list=[], after=None):
    headers = {'User-Agent': 'my-app/0.0.1'}
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"

    if after:
        url += f"?after={after}"

    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code != 200:
        return None

    data = response.json()
    hot_list += [post['data']['title'] for post in data['data']['children']]
    after = data['data']['after']

    # If 'after' is None, we have reached the
    # end of the list and return the hot_list
    if after is None:
        return hot_list
    else:
        return recurse(subreddit, hot_list, after)
