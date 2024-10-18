from typing import Annotated
from fastapi import FastAPI, File
from fastapi.responses import HTMLResponse, JSONResponse
import torch
import torchvision.transforms as T
from PIL import Image
import io
import numpy as np
import uvicorn
import google.generativeai as genai

# Initialize FastAPI app
app = FastAPI()

# Load the model
model_path = "landmark_classifier_model.pt"
model = torch.jit.load(model_path)
model.eval()

# Gemini API key
GOOGLE_API_KEY = "A*E"

# Configure Google Generative AI
genai.configure(api_key=GOOGLE_API_KEY)
gemini_model = genai.GenerativeModel('gemini-pro')

# Function to get detailed summary from Gemini API
def get_detailed_summary(landmark):
    try:
        prompt = f"""
        Title: {landmark}
        Location: (Optional: Add location information if available)

        **History:** Briefly describe {landmark}'s history and construction based on reliable sources.

        **Significance:** Explain the cultural or historical significance of {landmark}.

        **Architecture:** Describe the architectural style and notable features of {landmark}.

        **Interesting Facts:** Share any interesting facts or trivia about {landmark}.
        """

        response = gemini_model.generate_content(prompt)
        summary = response.text.strip()  # Extract the generated text, removing potential whitespace
        return summary
    except Exception as e:  # Catch potential errors gracefully
        print(f"Error generating summary: {e}")
        return "An error occurred while generating the summary. Please try again later."

# Prediction function
def predict_image(image_bytes):
    img = Image.open(io.BytesIO(image_bytes))
    timg = T.ToTensor()(img).unsqueeze_(0)

    with torch.no_grad():
        outputs = model(timg)
        softmax = torch.nn.functional.softmax(outputs, dim=1)
        softmax_np = softmax.cpu().numpy().squeeze()

    top5_idx = np.argsort(softmax_np)[-5:][::-1]
    top5_values = softmax_np[top5_idx]
    top5_classes = [model.class_names[i] for i in top5_idx]

    return top5_classes, top5_values

# Endpoint for HTML form
@app.get("/", response_class=HTMLResponse)
def upload_page():
    return """
    <!doctype html>
    <html>
        <head>
            <title>Upload an Image</title>
        </head>
        <body>
            <h1>Upload an Image to Classify</h1>
            <form action="/classify/" method="post" enctype="multipart/form-data">
                <input type="file" name="file">
                <input type="submit" value="Upload">
            </form>
        </body>
    </html>
    """

# Endpoint to classify image
@app.post("/classify/")
async def classify_image(file: Annotated[bytes, File()]):
    # image_bytes = await file.read()
    print(str(file))
    top5_classes, top5_confidences = predict_image(file)

    # Get the first prediction
    first_prediction = top5_classes[0]

    # Get the detailed summary from Gemini API
    detailed_summary = get_detailed_summary(first_prediction)

    response_data = {
        "prediction": first_prediction,
        "detailed_summary": detailed_summary
    }

    return JSONResponse(content=response_data)

if __name__ == "__main__":
    uvicorn.run(app, host='127.0.0.1', port=8000)
