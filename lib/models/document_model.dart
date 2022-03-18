
class DocumentModel{
   int? id;
   String? name,documentUrl;

   DocumentModel.instance();


  DocumentModel({required this.id,required this.name , required this.documentUrl});

   DocumentModel.fromJson(Map<String,dynamic> jsonObject){
     id = jsonObject['id'];
     name = jsonObject['name'];
     documentUrl = jsonObject['document_url'];
   }

   Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name' : name,
      'document_url' : documentUrl
    };
  }

  static List<DocumentModel> getDocumentListFromJson(List<Map<String,dynamic>> documentsJsonObject){
    List<DocumentModel> documents = [];
    for(var documentObject in documentsJsonObject){
      documents.add(DocumentModel.fromJson(documentObject));
    }
    return documents;
  }

}