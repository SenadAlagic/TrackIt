# TrackIt
<h3>Calorie tracking app</h3>
<i>Seminar work - Software development 2 - Faculty of Information Technologies</i> </br>
<i>Made by: Alagić Senad</i> </br>

## Credentials

#### Administrator:
	Email: adminovic@admin.com
	Pass:  admin123

#### General app user:
	Email: senad@gmail.com
	Pass:  senad123

#### PayPal:
	Email: sb-czg3331335783@personal.example.com
	Pass:  Qe47#WPv

</br>

## Building the dockerfile

Use ```docker build -t <name> <location> (.)```

## Code hygiene

<h4>Visual Studio</h4>

Format code: ```CTRL + K + D``` </br>
Sort usings: ```CTRL + R + G```

<h4>Visual Studio Code</h4>

Format code: ```SHIFT + ALT + F``` </br>
Sort imports: ```SHIFT + ALT + O```

<i>*Use relative import paths.</i>

</br>

## Running the code
Use ```docker-compose up --build``` to start the Docker container.

## Running the scaffold
Use ```Scaffold-DbContext 'Name=ConnectionStrings:DefaultConnection' Microsoft.EntityFrameworkCore.SqlServer -OutputDir Database -force -Context TrackItContext``` to scaffold the db