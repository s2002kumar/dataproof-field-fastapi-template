# DataProof field test

This fork exists only to run [DataProof](https://github.com/s2002kumar/DataProof)'s GitHub Action on a schema and migrations that DataProof's author did not write. It is not maintained, and nothing here is a contribution to, or endorsed by, the template's authors. **Use [the upstream repository](https://github.com/fastapi/full-stack-fastapi-template).**

## Source

- **Upstream:** [fastapi/full-stack-fastapi-template](https://github.com/fastapi/full-stack-fastapi-template), MIT License (`LICENSE`, unchanged).
- **Base branch `main`:** upstream commit [`cc480df7`](https://github.com/fastapi/full-stack-fastapi-template/commit/cc480df77620faab6c0ab1bc0541c4fe4dce3c65) (2024-07-22), whose schema is Alembic revision `9c0a54914c78`: `user` and `item` with integer keys.
- **The migration under test:** upstream commit [`e65b427`](https://github.com/fastapi/full-stack-fastapi-template/commit/e65b427ab1668dad8cab0ff7c0b514e651a269ae), "Edit refactor db models to use UUID's instead of integer ID's", the direct child of `cc480df7`. It adds revision `d98dd8ec85a3`, which replaces both tables' integer keys and the foreign key with UUIDs.

## What this fork adds on `main`, in one commit

- `dataproof/config.toml`, `dataproof/requirements.txt`, `dataproof/fixture.sql` and two oracles in `dataproof/oracles/`, written by DataProof's author for this test.
- `.github/workflows/dataproof.yml`, the Action pinned to a DataProof commit.
- This file, and a note at the top of `README.md`.
- **Removed:** the upstream workflows and `dependabot.yml`, so that only DataProof runs here and nothing deploys, comments or opens pull requests.

Nothing in `backend/` is changed. The upstream migration runs exactly as written, through its own `env.py`.

## The pull requests, and what DataProof should say before they run

| Pull request | Head | Written by | Expected |
| --- | --- | --- | --- |
| The upstream migration | `upstream-uuid`: `e65b427`, unchanged | The template's authors | `CHECKED`: every user and every item's owner survives the key change |
| A corrupted copy | `corrupt-owner-join`: `e65b427` plus one commit | DataProof's author | `BLOCKED`: the copy fills each item's new owner key by joining `"user".id = item.id` instead of `item.owner_id`, so items move to the wrong users or lose their owner |

The oracles compare what a user of the application would notice: each user by email, and each item's owner by the owner's email. Neither mentions an id, so neither needs a binding when the keys become UUIDs.

## What the configuration had to say

The template's `env.py` builds its URL from `POSTGRES_SERVER`, `POSTGRES_PORT`, `POSTGRES_USER`, `POSTGRES_PASSWORD` and `POSTGRES_DB`, and imports the application's models, so the configuration declares those variables as the disposable database's coordinates, sets `PYTHONPATH` to the backend directory, and pins the models' dependencies to this commit's `poetry.lock`. These are base-branch settings; the pull requests change none of them.

Results are recorded in DataProof's [field results](https://github.com/s2002kumar/DataProof/blob/main/docs/ACTION_FIELD_RESULTS.md), including any that go wrong.
