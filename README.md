## Error Case

Welcome to the `error_case` library. A library to define error cases that we can use to test our code.

### Features

- Data class validation
- Empty string validation
- Minimum number validation
- Maximum number validation
- More to come in the future...

### How to use

Let's start with an example of a data class.

```
class User implements JsonModel {

    User(this.id, this.name, this.address, this.age);

    final String id;
    final String name;
    final Map<String, String> address;
    final int age;

    factory User.fromJson(Map<String, dynamic> json) =>
        _$UserItemFromJson(json);

    @override
    Map<String, dynamic> toJson() => _$UserItemToJson(this);
}
```

In our data class `User` we have `id, name, address, age` properties.
This will be our sample data class throughout the guide.

It is important to note that this implements `JsonModel` a class that contains `fromJson()` & `toJson()` functions.

In this example I am also using `json_serializable` to generate `fromJson` & `toJson` functions.

```
class InvalidUserModelErrorCase extends ObjectSingleErrorCase {

    InvalidUserModelErrorCase(): super(
        ['id', 'name', 'address.country', age], // Required properties
        minimumValue: {'age': 21},
        maximumValue: {'age': 200}
    );
}

// P.S. There's a shorter way to implement this but we need Dart 2.16
```

In our error case we've defined our required fields `id, name, address.country, age`.

What is `address.country`? This defines a nested lookup that validates the keys it passes through and value at the end.

If we don't include a property of the class. It will be considered optional, no validation will happened to that property.

Let's see a brief example of how we use these classes we've written.

```
void main() {

    final user = User( // Here's a sample User class
        'ABCD1234', // id
        'David Hamster', // name
        {'country': 'Kingdom of Nocturnia'}, // address map
        24 // age
    );

    const errorCase = InvalidUserModelErrorCase();

    errorCase.validate(user,
    _onInvalidUserModel,
    _onValidUserModel);
}

void _onInvalidUserModel(Exception ex) {
    // 'ex' can be a child of ErrorCaseException or a different Exception altogether.
}

void _onValidUserModel(User user) {
    // When there are no errors, the data that was validated will be passed on as a parameter for this function.
}
```

To summarize the example above.

- We have a user class with data.
- We create a const of an Error case.
- We then call `.validate()` and pass `data, errorFunction, successFunction`.

### Non Returning Error Cases

These are error cases that do not expect a return value on the error and success functions.

#### Classes

- SingleErrorCase
- ObjectSingleErrorCase

See [error_case_test.dart](./test/error_case_test.dart)

### Returning Error Cases

These are error cases that expect a return value on the error and success functions.

#### Classes

- SingleErrorReturnCase
- ObjectSingleErrorReturnCase

See [error_case_return_test.dart](./test/error_case_return_test.dart)

### Good Practices

DO: Create a new error case class for a specific scenario. Just like when defining a Use Case for specific business logics.

DONT: Combine with other scenarios. This will make it difficult to locate where the error is happening when on reports.

--

DO: Declare a new instance of an error case with `const` for compile time benefits.

DONT: Declare a new instance of an error case without `const` on the UI code because it can be recreated.

### Developed by

- [Edamama](https://edamama.ph/)
- [Edamama Github Org](https://github.com/edamama-ph)

### Contributors

- [Azma Ahmed](https://www.linkedin.com/in/azma-ahmed-bb8940150/)
- [Gian Patrick Quintana](https://www.linkedin.com/in/gianpatrickquintana/)
- [Harsh Chaurasia](https://www.linkedin.com/in/harsh-chaurasia/)
- [Omkar Gaikwad](https://www.linkedin.com/in/omkar-gaikwad-96a380167/)
- [Pruitvi Sandiri](https://www.linkedin.com/in/pruithvi-sandiri-b01214103/)
- [Reyster Fresco](https://github.com/reysterf/)
- [Shiv Pratap Singh](https://www.linkedin.com/in/shiv-pratap-singh-bb8609a7/)
- [Shubhanshu Singh](https://www.linkedin.com/in/shubhanshu-singh-151410/)
