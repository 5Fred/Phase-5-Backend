# README 
AUTHORS = EMMAUNUEL MUKIRA , CLIFF MUDIGO , FREDRICK , KENNEDY MBUGUA , VICTOR IRERI.

News Sentiment Analysis Backend
This is the backend component of the News Sentiment Analysis application, which provides APIs for user management, news article management, sentiment analysis integration, and user preferences. The backend is built using Ruby on Rails and integrates with IBM Watson's Natural Language Understanding API for sentiment analysis.

Ruby Version
The backend is developed using Ruby version X.X.X. Make sure you have Ruby installed on your system before running the application.

System Dependencies
Before running the application, ensure that the following dependencies are installed on your system:

Ruby (version X.X.X)
Ruby on Rails (version X.X.X)
PostgreSQL (version X.X.X)
Configuration
Clone the repository to your local machine.

Install the required Ruby gems by running the following command in the project directory:

Copy code
bundle install
Set up the database configuration by updating the config/database.yml file with your PostgreSQL credentials.

Database Creation
To create the database, run the following command:

lua
Copy code
rails db:create
Database Initialization
To set up the initial database schema and seed data, run the following commands:

Copy code
rails db:migrate
rails db:seed
This will create the necessary tables and populate the database with sample data.

How to Run the Test Suite
To run the test suite and ensure that all the functionalities are working correctly, execute the following command:

Copy code
rspec
Services (Job Queues, Cache Servers, Search Engines, etc.)
Currently, the backend does not utilize any external services or job queues. The sentiment analysis is performed synchronously using IBM Watson's API within the API endpoints.

API Endpoints
The backend provides the following API endpoints:

User Registration: POST /api/v1/users/register
User Login: POST /api/v1/users/login
User Authentication: JWT-based authentication is used for securing API endpoints.
News Articles Management: CRUD operations for news articles' metadata are available at api/v1/articles endpoint.
Sentiment Analysis Integration: Sentiment analysis is performed using IBM Watson's Natural Language Understanding API. The sentiment analysis results are stored in the database along with news articles' metadata.
User Preferences APIs
The backend provides APIs to handle user-specific sentiment analysis preferences and bookmarking functionalities. These APIs allow users to customize their sentiment analysis settings and bookmark their favorite news articles.

Deployment Instructions
To deploy the backend to a production server, follow these general steps:

Set up a production environment with the necessary dependencies (e.g., Ruby, Rails, PostgreSQL, etc.).
Configure the production database settings in config/database.yml.
Set the necessary environment variables, including the IBM Watson API key and any other sensitive information.
Precompile assets (if applicable) using rails assets:precompile.
Deploy the application to the server (e.g., using Capistrano, Heroku, or any other deployment tool).
Please ensure that you handle sensitive information securely and follow best practices for production deployment.

For more information on using the frontend with this backend, please refer to the frontend README.

Contributions
Contributions to the News Sentiment Analysis backend are welcome! If you find any issues or have suggestions for improvements, please feel free to create a pull request or open an issue on the GitHub repository.

Thank you for using the News Sentiment Analysis backend! If you have any questions or need further assistance, please don't hesitate to reach out. Happy coding!






Regenerate
