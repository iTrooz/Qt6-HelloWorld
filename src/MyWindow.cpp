#include "MyWindow.h"
#include <iostream>

MyWindow::MyWindow(QWidget *parent) :
        QWidget(parent) {

    // Set size of the window
    setFixedSize(200, 100);

    // Create and position the button
    m_button = new QPushButton("Hello World", this);
    m_button->setGeometry(10, 10, 80, 30);


    std::cout << "Executing my window! \n";
}
