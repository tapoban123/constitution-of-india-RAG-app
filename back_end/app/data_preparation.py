from langchain_community.document_loaders import PyPDFLoader
from langchain_core.documents import Document

import re
import os
from pydantic import BaseModel

from utils.documents_mng import clean_and_prepare_docs
from utils.pinecone_db_mng import PineconeManager


class Doc(BaseModel):
    filename: str
    file_path: str
    start_page: int
    end_page: int


file_data: list[Doc] = []
page_nos_pattern = r'Page-(\d+)-(\d+)'

files = os.listdir("data")
for file in files:
    filepath = os.path.join("data", file)
    match = re.search(pattern=page_nos_pattern, string=file)
    page_nos = [int(match.group(1)), int(match.group(2))]

    doc = Doc(
        file_path=filepath,
        filename=file,
        start_page=page_nos[0],
        end_page=page_nos[1],
    )

    file_data.append(doc)

clean_docs: list[Document] = []

# load, clean and upload
for doc in file_data:
    # load
    loader = PyPDFLoader(file_path=doc.file_path)
    pages = loader.load()

    # clean
    clean_docs.extend(clean_and_prepare_docs(docs=pages, end_page_num=doc.end_page, start_page_num=doc.start_page, ))



pinecone_mng = PineconeManager(index_name="indian-constitution")
# pinecone_mng.create_index()
# pinecone_mng.save_docs_to_index(docs=clean_docs)








# query = input("Enter a query: ")
#
# answer, page_nos = pinecone_mng.perform_similarity_search(query=query)
#
# print(answer, end="\n" * 3)
# print(page_nos)

# for clean in clean_docs:
#     # print(clean.metadata["page_label"])
#     # print(clean.page_content, flush=True, end="\n" * 5)
#     if clean.metadata["page_label"] == 420:
#         print(clean.page_content, flush=True)


# print(clean_docs[0].metadata)
# print(clean_docs[-1].metadata["page_label"])
