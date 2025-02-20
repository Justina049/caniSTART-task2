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

  public shared({ caller }) func show_favorite_number() : async ?Nat {
    favouriteNumber.get(caller)
  }; 
  
}