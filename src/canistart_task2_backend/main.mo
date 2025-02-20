import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";

actor {
  // Challenge 1: Function to check if the caller is anonymous
  public shared ({ caller }) func isAnonymous() : async Bool {
    Principal.isAnonymous(caller)
  };

  let favouriteNumber = HashMap.HashMap<Principal, Nat>(10, Principal.equal, Principal.hash);
}