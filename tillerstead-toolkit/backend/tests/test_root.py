import pytest
from httpx import AsyncClient

from app.main import app


@pytest.mark.asyncio
async def test_root_endpoint():
    async with AsyncClient(app=app, base_url="http://test") as ac:
        resp = await ac.get("/")
    assert resp.status_code == 200
    j = resp.json()
    assert "name" in j and "version" in j and j.get("status") == "running"
