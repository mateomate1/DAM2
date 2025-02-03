import fastapi
import uvicorn

app = fastapi.FastAPI()

@app.get("/localidad")
def getLocalidad():
    return {"Localidad":"madrid"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=1000)