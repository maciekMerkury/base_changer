// this file will contain all the macros that i used

#[macro_export]
/// personalised exit macro
macro_rules! pexit {
    ( $text:expr, $code:expr ) => {
        eprintln!($text);
        std::process::exit($code);
    }
}

