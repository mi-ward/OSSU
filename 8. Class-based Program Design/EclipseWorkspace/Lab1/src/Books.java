class Book {
	String title;
	Author author;
	Publisher publisher;
	int price;
	
	Book(String title, Author author, Publisher publisher, int price) {
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.price = price;
	}
}

class Author {
	String name;
	int yob;

	Author(String name, int yob) {
		this.name = name;
		this.yob = yob;
	}
}

class Publisher {
	String name;
	String country;
	int openyear;
	
	Publisher(String name, String country, int openyear) {
		this.name = name;
		this.country = country;
		this.openyear = openyear;
	}
}

class ExamplesBooks {
	ExamplesBooks() {}
	
	Author pat = new Author("Pat Conroy", 1948);
	Publisher scholastic = new Publisher("Scholastic", "US", 1850);
	Book beaches = new Book("Beaches", this.pat, this.scholastic, 20);
}