from invoke import Collection, task
from _docs import doc, intl


@task
def virtualenv(c):
    '''create and install env'''
    c.run('pip install -U pipenv')
    c.run('pipenv install --dev')


@task
def run(c, target='build-site'):
    '''
    :target: can be `update-docs`, `build-site`, `serve-site`
    '''
    c.run(f'python -m pipenv run python update.py --{target}')


ns = Collection(intl, doc, run, virtualenv)