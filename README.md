# MoneyTransfer
A simple prototype money transfer app that uses Protocol Oriented Programming, TDD and MVVM Architecture.

![simulatorscreenshot-iphonex-a](https://user-images.githubusercontent.com/5734082/43367435-5939449a-937f-11e8-94c1-3507af9ba304.png)          ![simulatorscreenshot-iphonex-b](https://user-images.githubusercontent.com/5734082/43367444-86b4c908-937f-11e8-9560-f90820590526.png)

This project was developed by following Protocol Oriented Programming and Test Driven Development using Model View ViewModel Architecture.

# Protocol Oriented Programming
 Before starting to build the module, Models and ViewModels are started by creating protocols to implement. Only when initial protocols have been defined, models are created and viewModels are build with empty implementations.
 
# Test Driven Development
 After creating the application blueprint(protocols), Test Case are now built to run failing and success(mocked scenario and data) cases. In this process continuous refactoring is done in order to polish Application Behavior and predict errors to handle in our Test Cases. After Application Test Cases and Behaviours have finished, ViewModel(Business logic) is now coded for implementation.
 
 # MVVM Architecture
  Using this architecture, layer's roles are well defined and decoupled. Thus creating a flexible and clear application layers. Wireframe was also added in this architecture to give the module flexibilty on presenting other sub modules or UIViewControllers.

# Notes:
In order to pass test cases uncomment lines 181 and 182 in MoneyTransferViewModel.swift because these lines leads to the TranferMoneyReport Module with report comming from the json(static data) hosted online. If lines are left commented it will generate a Report based on the user input after succesfully running transaction request.
