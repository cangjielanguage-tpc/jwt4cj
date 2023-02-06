package jwt

import jwt.algorithms.Algorithm
import jwt.interfaces.*
import jwt.exception.*
import jwt.impl.*
from std import collection.* 
from std import time.*


public class BaseJWTVerifier <: JWTVerifier {

    private let algorithm: Algorithm;

    private let expectedChecks: ArrayList<ExpectedCheckHolder>;
    
    private let parser: JWTParser;

    init(algorithm: Algorithm, expectedChecks: ArrayList<ExpectedCheckHolder>) {
        this.algorithm = algorithm;
        this.expectedChecks = expectedChecks;
        this.parser = JWTParser();
    }

    static func builder(algorithm: Algorithm): Verification{
        try  {
            return  BaseVerification(algorithm)
        } catch(e: IllegalArgumentException) {
            throw IllegalArgumentException("Illegal Argument " + algorithm.toString())
        }
        
    }

    public func verify(token: String): DecodedJWT {
        var jwt: DecodedJWT = JWTDecoder(parser, token);
        return verify(jwt);
    }

    /**
     * Perform the verification against the given decoded JWT, using any previous configured options.
     *
     * @param jwt to verify.
     * @return a verified and decoded JWT.
     * @throws AlgorithmMismatchException     if the algorithm stated in the token's header is not equal to
     *                                        the one defined in the {@link JWTVerifier}.
     * @throws SignatureVerificationException if the signature is invalid.
     * @throws TokenExpiredException          if the token has expired.
     * @throws MissingClaimException          if a claim to be verified is missing.
     * @throws IncorrectClaimException        if a claim contained a different value than the expected one.
     */
    public func verify(jwt: DecodedJWT): DecodedJWT {
        
        verifyAlgorithm(jwt, algorithm);
        algorithm.verify(jwt);
        verifyClaims(jwt, expectedChecks);
        return jwt;
       
    }

    private func verifyAlgorithm(jwt: DecodedJWT, expectedAlgorithm: Algorithm) {
        // let a = jwt.getAlgorithm()                           
        // match(a){
        //     case Some(v) => if(v!=expectedAlgorithm.getName()){throw Exception()}
        //     case None => throw AlgorithmMismatchException(
        //         "The provided Algorithm doesn't match the one defined in the JWT's Header.");
        // }
        if (!expectedAlgorithm.getName().equals(jwt.getAlgorithm())) {
            throw AlgorithmMismatchException(
                "The provided Algorithm doesn't match the one defined in the JWT's Header.");
        }
    }

    private func verifyClaims(jwt: DecodedJWT, expectedChecks: ArrayList<ExpectedCheckHolder>) {
        for (expectedCheck in expectedChecks) {
            
            var isValid: Bool;
            var claimName: String = expectedCheck.getClaimName();
            var claim: Claim = jwt.getClaim(claimName);

            // if (claim.isMissing() && claimName != "exp" && claimName != "nbf" && claimName != "iat") {
            //     println("missing")
            //     throw MissingClaimException(claimName)
            // }
            isValid = expectedCheck.verify(claim, jwt);

            if (!isValid) {
                throw IncorrectClaimException(
                        "The Claim '${claimName}' value doesn't match the required one.",
                        claimName,
                        claim
                );
            }
        }
    }

}