# 🏛️ Indian Constitution AI: Bringing the Law of the Land to Your Fingertips

An intelligent, high-performance RAG (Retrieval-Augmented Generation) application designed to make the **Indian Constitutional Law by MP Jain** accessible, searchable, and understandable for everyone.

---

## 📱 Experience the App

https://github.com/user-attachments/assets/ed56eea8-6e74-498b-8a8d-fa5c56656fb5

---

## 💡 The Problem & The Solution
The Indian Constitution is one of the most comprehensive legal documents in the world. For most people, finding specific information or understanding legal nuances within its hundreds of articles is a daunting task.

**Constitution AI** solves this by acting as a bridge between the citizen and the document. It doesn't just guess; it retrieves the exact legal context from the official text and explains it in simple, human terms. 

### What makes this different?
- **Zero Hallucination**: The system is strictly instructed to only answer using the retrieved context from the constitution. If it isn't in the law, it won't be in the answer.
- **Evidence-Based**: Every response includes **Page Numbers** from the original document so users can verify the information themselves.
- **Privacy First**: Chat history is stored locally on the device using Hive, giving users full control over their data.

---

## 🛠️ The Tech Stack

### Frontend: Flutter (Mobile Excellence)
- **State Management**: Implemented using **Bloc/Cubit** for a clean, predictable, and scalable architecture.
- **Local Database**: **Hive** was chosen for its lightning-fast NoSQL capabilities, perfect for seamless chat history persistence.
- **Responsive Layouts**: Utilizes **ScreenUtil** to ensure the premium design remains consistent across various screen sizes and densities.

### Backend: FastAPI & LangChain (The Brain)
- **RAG Engine**: Powered by **LangChain**, orchestrating the flow between vector retrieval and response generation.
- **Vector Database**: **Pinecone** handles semantic searches, allowing the app to find the most relevant legal clauses in milliseconds.
- **LLM**: Integrated with **Mistral Large** via MistralAI, delivering high-reasoning capabilities while maintaining strict adherence to the provided context.
- **Deployment**: Hosted on **Vercel** as a serverless API for high availability and low latency.

---

## 📖 Source Material
The app is trained on and retrieves information from the following official source:
- **Indian Constitutional Law by MP Jain**: [https://drive.google.com/drive/folders/13bKADgN7D-VFHxy2gbbHJZLtPlTXdsMw?usp=sharing](https://drive.google.com/drive/folders/13bKADgN7D-VFHxy2gbbHJZLtPlTXdsMw?usp=sharing)

---

## 📂 Project Structure

- **`constitution_app/`**: The Flutter codebase. Focuses on a buttery-smooth UI and robust state management.
- **`back_end/api/`**: The Python FastAPI service. This is where the heavy lifting of semantic search and AI synthesis happens.

---

## ⚙️ How it Works (Under the Hood)
1. **The Query**: A user asks a question like "What are my fundamental rights regarding education?"
2. **The Retrieval**: The FastAPI backend converts the query into an embedding and searches the **Pinecone** vector store.
3. **The Synthesis**: The top relevant chunks of the constitution are passed to **Mistral AI** with a custom prompt.
4. **The Response**: The AI generates a summary, ensuring it uses nothing but the provided text, and returns the result along with the source page numbers to the Flutter app.

---

## 🚀 Getting Started

### Local API Setup
1. Navigate to `back_end/api`.
2. Install requirements: `pip install -r requirements.txt`.
3. Set up your `.env` with `MISTRAL_API_KEY` and `PINECONE_API_KEY`.
4. Run locally: `fastapi dev main.py`.

### Flutter App Setup
1. Navigate to `constitution_app`.
2. Fetch dependencies: `flutter pub get`.
3. Connectivity: Ensure the `ai_generation_service.dart` points to your local or deployed API URL.
4. Launch: `flutter run`.

---

## 🤝 Let's Connect
This project demonstrates a full-stack implementation of modern AI patterns (RAG) combined with professional mobile development practices. If you're looking for a developer who understands the intersection of AI and User Experience, let's talk.


[<img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" />](https://www.linkedin.com/in/tapobanray/)
