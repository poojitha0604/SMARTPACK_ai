# SmartPack AI

SmartPack AI identifies food from a photo and recommends suitable packaging. It also provides storage guidance, alternatives, and an approximate spoilage-risk estimate. The website supports English, Hindi, and Telugu.

## Models

- **Food identification (deep learning):** "TensorFlow/Keras" is image classifies , dl model is  "MobileNetV2", fine-tuned to recognize Apple, Banana, Bread, Carrot, Mango, Onion, Orange, Potato, Potato Chips, and Tomato.
- **Packaging recommendation (machine learning):** scikit-learn compares Decision Tree, Random Forest, KNN, and Logistic Regression, then saves the best model. The current model is a Decision Tree.
- **Packing advice and spoilage risk:** Rule-based guidance, not model predictions.

The packaging model is trained on generated example data, so its high test score does not guarantee real-world accuracy. Image recognition can also make mistakes; check its prediction.

## Start the app

On Windows, open the project folder in a terminal and run:

```cmd
setup.bat
run.bat
```

Open **http://localhost:5000**. Keep the terminal open while using the app. To stop it, press **Ctrl+C**. To start it again later, run `run.bat`; setup is only needed once.

To start the app directly from Command Prompt instead of using `run.bat`, first run `setup.bat` once if you have not already set up the project. Then, from the project folder, run:

```cmd
venv\Scripts\activate
cd backend
python app.py
```

Open **http://localhost:5000** in your browser. Keep the terminal open while using the app, and press **Ctrl+C** to stop it.

## Train the models

The packaging model is prepared by `setup.bat`. To rebuild it:

```cmd
venv\Scripts\activate
python ml\generate_dataset.py
python ml\train_model.py
```

To train the food image model, put the extracted image datasets in `downloads\fruitveg` and `downloads\food11`, then run:

```cmd
venv\Scripts\activate
pip install -r dl\requirements.txt
python datasets\prepare_dataset.py --fruitveg downloads\fruitveg --food11 downloads\food11 --max-per-class 150
```

Add reviewed potato-chip images to `datasets\images\potato_chips` if needed. Check that every class has at least 20 usable images, then train:

```cmd
python datasets\prepare_dataset.py --check
python dl\train_model.py
```

The image model and reports are saved in `dl\models`. Downloaded datasets, training photos, and model files are excluded from Git; a fresh clone needs the datasets and training steps above before image predictions will work.

## Project folders

- `frontend/` — website
- `backend/` — Flask API and SQLite database
- `ml/` — packaging model training and prediction
- `dl/` — food image model training and prediction
- `datasets/` — training data preparation and generated data

## API

- `POST /api/detect-food` — identify food in an uploaded image
- `POST /api/recommend` — recommend packaging for food and storage details
- `GET /api/foods` — list supported foods
- `GET /api/health` — check app and model status
