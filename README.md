# Quiz Application

A Spring Boot-based web application for creating and managing quizzes with user authentication and security features.

## Technical Specifications

### Technologies Used
- **Backend Framework**: Spring Boot 3.4.4
- **Java Version**: 17
- **Database**: MySQL
- **View Technology**: JSP with JSTL
- **Security**: Spring Security
- **Build Tool**: Maven
- **Additional Libraries**:
  - Spring Data JPA
  - Spring Validation
  - Lombok
  - Spring Security Taglibs
  - Spring Boot DevTools

### Project Structure
```
src/main/java/com/quiz/
├── config/         # Configuration classes
├── controller/     # REST controllers
├── dto/           # Data Transfer Objects
├── entity/        # JPA entities
├── repository/    # JPA repositories
├── security/      # Security configuration
└── service/       # Business logic
```

## Prerequisites

- Java 17 or higher
- MySQL Server
- Maven 3.6 or higher
- Git (optional)

## Installation Steps

### For Windows

1. **Install Java**
   - Download and install Java 17 JDK from Oracle's website
   - Set JAVA_HOME environment variable

2. **Install MySQL**
   - Download and install MySQL Server
   - Create a database named 'quiz'
   - Update application.properties with your MySQL credentials

3. **Install Maven**
   - Download and install Maven
   - Add Maven to your PATH

4. **Clone and Run**
   ```bash
   git clone [your-repository-url]
   cd quiz-app
   mvn clean install
   mvn spring-boot:run
   ```

### For macOS

1. **Install Java**
   ```bash
   brew install openjdk@17
   ```

2. **Install MySQL**
   ```bash
   brew install mysql
   brew services start mysql
   mysql -u root -p
   # Create database
   CREATE DATABASE quiz;
   ```

3. **Install Maven**
   ```bash
   brew install maven
   ```

4. **Clone and Run**
   ```bash
   git clone [your-repository-url]
   cd quiz-app
   mvn clean install
   mvn spring-boot:run
   ```

## Application Features

- User authentication and authorization
- Quiz creation and management
- Secure REST APIs
- JSP-based user interface
- Database persistence using JPA
- Input validation
- Hot reload support for development

## Configuration

The application requires the following configurations in `application.properties`:
- Database connection details
- Server port
- Security settings

## Development

- The application uses Spring Boot DevTools for hot reloading
- Lombok is used for reducing boilerplate code
- JSP with JSTL is used for the view layer
- Spring Security is implemented for authentication and authorization

## License

This project is licensed under the terms specified in the LICENSE file.

## Support

For support, please refer to the HELP.md file or create an issue in the repository. 