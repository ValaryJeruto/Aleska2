const sqlite3 = require('sqlite3').verbose();
const db = new sqlite3.Database('alaskena_school.db');

db.serialize(() => {
    db.run("CREATE TABLE IF NOT EXISTS news (id INT, title TEXT, description TEXT)");

    const stmt = db.prepare("INSERT INTO news VALUES (?, ?, ?)");
    stmt.run(1, 'New Dormitory', 'New dormitory construction is underway.');
    stmt.finalize();
});

db.each("SELECT * FROM news", (err, row) => {
    console.log(row.title + ": " + row.description);
});

db.close();
