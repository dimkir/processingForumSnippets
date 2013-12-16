XML xml;

void setup() {
  xml = loadXML("mammals.xml");
  XML[] animals = xml.getChildren("animal");

  for (int i = 0; i < animals.length; i++) {
    println(animals[i].getContent());
  }
}
