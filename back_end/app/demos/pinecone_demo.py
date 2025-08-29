import time
from pinecone import Pinecone, CloudProvider, AwsRegion, IndexEmbed, EmbedModel, Metric

from utils.constants import PINECONE

pc = Pinecone(api_key=PINECONE.API_KEY.value)

index_name = "constitution-vectordb"
if not pc.has_index(index_name):
    pc.create_index_for_model(name=index_name,
                              cloud=CloudProvider.AWS,
                              region=AwsRegion.US_EAST_1,
                              embed=IndexEmbed(
                                  model=EmbedModel.Multilingual_E5_Large,
                                  field_map={"text": "chunk_text"},
                                  metric=Metric.COSINE,
                              ))

records = [
    {"_id": "rec1", "chunk_text": "The Eiffel Tower was completed in 1889 and stands in Paris, France.",
     "category": "history"},
    {"_id": "rec2", "chunk_text": "Photosynthesis allows plants to convert sunlight into energy.",
     "category": "science"},
    {"_id": "rec3", "chunk_text": "Albert Einstein developed the theory of relativity.", "category": "science"},
    {"_id": "rec4", "chunk_text": "The mitochondrion is often called the powerhouse of the cell.",
     "category": "biology"},
    {"_id": "rec5", "chunk_text": "Shakespeare wrote many famous plays, including Hamlet and Macbeth.",
     "category": "literature"}, ]

dense_index = pc.Index(index_name)
dense_index.upsert_records("sample_data", records)

time.sleep(10)

stats = dense_index.describe_index_stats()
print(stats)

query = "Famous historical structures and monuments"

results = dense_index.search(
    namespace="sample_data",
    query={
        "top_k": 10,
        "inputs": {
            "text": query
        }
    }
)

print(results)
