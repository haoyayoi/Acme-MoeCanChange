if (-f "t/test.db") { 
    system "rm t/test.db";
}
system "sqlite3 t/test.db < sql/sqlite.sql";
unless (-f "t/test.db") {
    die "failed to create sqlite database file! check 'sqlite3 --version'";
}

