#!/usr/bin/python3
"""Function that queries the Reddit API"""
import requests


def count_words(subreddit, word_list, hot_list=[], after=None):
    """
    Recursive function it will queries the Reddit API
    Parses the title of all hot articles, and prints a sorted count
    of given keywords
    Returns None if no results are found for the given subreddit.
    """
    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    if after:
        url += f"?after={after}"

    headers = {
        'User-Agent': 'python:subreddit.hot.posts:v1.0 (by /u/yourusername)'}
    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        data = response.json()
        posts = data['data']['children']
        for post in posts:
            hot_list.append(post['data']['title'])

        after = data['data']['after']
        if after:
            return count_words(subreddit, word_list, hot_list, after)
        else:
            word_count = {word.lower(): 0 for word in word_list}
            for title in hot_list:
                title_words = title.lower().split()
                for word in word_list:
                    word_count[word.lower()] += title_words.count(word.lower())

            sorted_word_count = sorted(
                [(word, count)
                 for word, count in word_count.items() if count > 0],
                key=lambda x: (-x[1], x[0])
            )

            for word, count in sorted_word_count:
                print(f"{word}: {count}")
    else:
        return None
