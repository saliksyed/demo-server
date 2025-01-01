FROM python:3.12.3
ADD ./app /
RUN pip install poetry==1.8.5

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

RUN --mount=type=cache,target=$POETRY_CACHE_DIR poetry install --no-root
CMD poetry run gunicorn --bind 0.0.0.0:5000 app.app:app