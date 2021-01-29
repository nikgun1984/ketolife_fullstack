
def partition_list(lst,n):
    """Divide ingredients into grid for displaying on front page"""

    return [lst[i * n:(i + 1) * n] for i in range((len(lst) + (n-1)) // n )]