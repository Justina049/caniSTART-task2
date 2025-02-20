import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";

actor {
  // Challenge 1: Function to check if the caller is anonymous
  public shared ({ caller }) func isAnonymous() : async Bool {
    Principal.isAnonymous(caller)
  };

  // Challenge 2: Create a HashMap to store favorite numbers
  let favouriteNumber = HashMap.HashMap<Principal, Nat>(10, Principal.equal, Principal.hash);

  // Challenge 3: Function to add a favorite number
  public shared({ caller }) func add_favourite_number(n: Nat) : async () {
    favouriteNumber.put(caller, n);
  };

  // Function to show the favorite number
  public shared({ caller }) func show_favorite_number() : async ?Nat {
    favouriteNumber.get(caller)
  }; 

  // Challenge 4: Modified add_favorite_number function
  public shared ({ caller }) func add_favourite_number_v2(n: Nat) : async Text {
    switch (favouriteNumber.get(caller)) {
      case (?_) { "You have already registered your number" };
      case null {
        favouriteNumber.put(caller, n);
        "You have Successfully registered your number"
      };
    }
  };

};