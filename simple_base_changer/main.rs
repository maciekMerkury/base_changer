use std::env::args;

/// personalised exit macro
macro_rules! pexit {
    ( $text:expr, $code:expr ) => {
        eprintln!($text);
        std::process::exit($code);
    }
}

fn main() {
    let argv = args().collect::<Vec<String>>();

    if argv.len() < 2 {
        pexit!("a number has to be provided", 1);
    }
    
    if !argv[1].parse::<u128>().is_ok() {
        pexit!("the string given is not a number", 2);
    }

    // we know that the chars together create a u128 number, so we can just unwrap the Option
    // we know that the value of a char is 0 <= c <= 9, so we can just dumly convert between u32 and u8
    let nums: Vec<u8> = argv[1].chars().map(|c|c.to_digit(10).unwrap() as u8).collect();

    let mut base10_num: u128 = 0;

    for n in nums.iter() {
        if n > &6 {
            pexit!("number is clearly not in base6", 3);
        }
    }

    for i in (0..nums.len()).rev() {
        #[cfg(debug)]
        println!("(i: {:?}, n: {:?})", i, nums[nums.len() - 1 - i]);

        #[cfg(debug)]
        println!("adding to the output number: {}", nums[nums.len() - 1 - i] as u128 * 6_u128.pow(i as u32));

        base10_num += nums[nums.len() - 1 - i] as u128 * 6_u128.pow(i as u32);
    }

    println!("{}", base10_num);
}

