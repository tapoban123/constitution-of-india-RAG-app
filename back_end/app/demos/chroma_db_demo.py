import chromadb

chroma_client = chromadb.CloudClient(
    api_key='ck-94QW12GShwwMMP2WqZzpZPdVXgfmDsQuz9Yn64hPAEkS',
    tenant='cef8c492-9d8e-4ee2-b0cc-cf3e6940df95',
    database='OneGo_VectorDB'
)

collection = chroma_client.get_or_create_collection(name="test_collection")

collection.upsert(
    documents=[
        "This is a document about pineapple",
        "This is a document about oranges"
    ],
    ids=["id1", "id2"],
)

results = collection.query(
    query_texts=["This is a query document about florida"],  # Chroma will embed this for you
    n_results=2  # how many results to return
)

print(results)
