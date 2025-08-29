from langchain_community.document_loaders import PyPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_pinecone import PineconeVectorStore
from langchain_google_genai import GoogleGenerativeAIEmbeddings
from utils.constants import GOOGLE_GENAI, PINECONE
from pinecone import Pinecone, CloudProvider, AwsRegion, Metric, IndexEmbed, EmbedModel, ServerlessSpec
from langchain_mistralai import MistralAIEmbeddings

pc = Pinecone(api_key=PINECONE.API_KEY.value)
pinecone_index_name = "indian-constitution"
# pc.delete_index(pinecone_index_name)

if not pc.has_index(pinecone_index_name):
    pc.create_index(name=pinecone_index_name,
                    metric="cosine",
                    # The Gemini embedding model `gemini-embedding-001` uses
                    # 3072 dimensions.
                    dimension=1024,
                    spec=ServerlessSpec(
                        cloud=CloudProvider.AWS,
                        region=AwsRegion.US_EAST_1,
                    ))

loader = PyPDFLoader(file_path="data/MP Jain-page-1-1511/01-Page-1-29.pdf")
pages = loader.load()
# embedding_model = GoogleGenerativeAIEmbeddings(google_api_key=GOOGLE_GENAI.API_KEY.value,
#                                                model=GOOGLE_GENAI.EMBEDDING_MODEL.value, )

# print(pages[0].metadata, pages[-1].metadata)


embedding_model = MistralAIEmbeddings(
    model="mistral-embed",
)
splitter = RecursiveCharacterTextSplitter(
    chunk_size=1200,
    chunk_overlap=150,
)

docs = splitter.split_documents(pages)

constitution_vector_store = PineconeVectorStore.from_documents(docs,
                                                               index_name=pinecone_index_name,
                                                               embedding=embedding_model,
                                                               )


# import re
#
# def clean_text_for_rag(text: str) -> str:
#     """
#     Perform moderate cleaning on extracted text to prepare
#     for Retrieval-Augmented Generation (RAG) applications.
#
#     Retains legal meaning but removes PDF formatting noise.
#     """
#     # 1. Remove page headers/footers like "Introductory [Chap 1" or "Syn A]"
#     text = re.sub(r'\b(Syn\s+[A-Z]+\]?)', ' ', text)
#     text = re.sub(r'\[\s*Chap.*?\]', ' ', text)
#
#     # 2. Remove page numbers or isolated digits on their own line
#     text = re.sub(r'^\s*\d+\s*$', ' ', text, flags=re.MULTILINE)
#
#     # 3. Remove multiple dots / repeated ellipses
#     text = re.sub(r'\.{2,}', '.', text)
#
#     # 4. Fix hyphenation at line breaks ("gov- ernment" → "government")
#     text = re.sub(r'(\w+)-\s+(\w+)', r'\1\2', text)
#
#     # 5. Normalize whitespace (collapse multiple spaces/newlines)
#     text = re.sub(r'\s+', ' ', text).strip()
#
#     # 6. Remove excessive case references citations e.g. "AIR 1997 SC 1390"
#     # (optional depending on whether you want them).
#     text = re.sub(r'\bAIR\s+\d{4}\s+SC\s+\d+\b', '', text)
#     text = re.sub(r'\(\d{4}\)\s*\d+\s*\w+\s*\d+', '', text)
#
#     # 7. Remove stray footnote numbers (e.g., "....12" or superscripts)
#     text = re.sub(r'\d+\s*\)', '', text)
#     text = re.sub(r'\s\d+\s', ' ', text)
#
#     return text
