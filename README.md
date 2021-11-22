# IOSProgrammingExam

### 1. Model/UserManager.swift
Her har jeg en Manager som administrer alt som har med APIet å gjøre. Denne manageren er ansvarlig for å fetche seed fra DataModel og utføre API-kallet.
Når API kalle er utført, mapper den gjennom dataene og lagrer i Databasen.
NB : før jeg lagrer i DB sjekker jeg om brukeren allerede eksisterer i databasen, hvis den gjør det hopper jeg over objektet for å unngå å ha to objekter av samme bruker.

### 2. Model/SeedManager.swift
Applikasjonen bruker seed : "IOS" på default, dette oppnådde jeg ved å detekte når appen kjøres for første gang på simulator og presistere seed.
Denne Manageren er også ansvarlig for å oppdatere seed i databasen og slette uendret brukere når seed oppdateres.

### 3. Oppdatering av brukernes opplysninger
Når en trykker på update, er det bare å gå til første skjerm(tableViewController) for å se oppdatert informasjon.
Jeg bruker NSFetchedResultsController som gjør at grensesnittet blir informert om oppdateringer og sletting fra databasen uten at brukeren refresher manuelt.
Når fødselsdatoen til en brukeren oppdateres, vil alderen også endre seg.

### 4. Oppdatering av seed
Når man lagrer en ny seed, vil alle brukere som ikke har blir endret slettes og applikasjonen vil da beholde de som er endret.
Når man trykker på SAVE og går tilbake til tabellen, vil kun de brukerne som har blitt endret vises. For å benytte den nye seeden for å hente nye brukere er det bare å dra ned på skjermen.

### 5. MapView

På MapView har jeg implementert alt eksamenstext ber om. Men jeg fikk ikke til en funksjonalitet som åpner profilen ved å trykke på bilde.
Jeg har løst det med å legge til en rightCalloutAccessoryView som dukker opp med infoLight-ikon når man trykker på bildet. Dette ikonet kan man trykke på for å åpne profilen til den brukeren.
