import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:vivo_registry/constants.dart';
import 'package:web3dart/web3dart.dart';

//------------------ETHEREUM VARIABLES---------------------------------------//
late Client httpClient;
late Web3Client ethClient;
late Credentials credentials;
late EthereumAddress myAddress;
late EthereumAddress contractAddress;
late String abi;

String rpcUrl = "https://rinkeby.infura.io/v3/342e2e0a9f184a888f0a1c3cb59172ff";
String privateKey = box.read("private_key");
// String privateKey = '47a0df710fded16b8a26bd6cb45533e80a1939ea7674ba48a08b06063c76f410';

late DeployedContract contract;
late ContractFunction totalRegistered, registerPhone, updateEntry, vivophones;

// ----------------------------- Initilizing Clients ----------------------------- //
Future<void> initialSetup() async {
  httpClient = Client();
  ethClient = Web3Client(rpcUrl, httpClient);
}

// ----------------------------- Fetching Account ----------------------------- //
Future<void> getCredentials() async {
  credentials = await ethClient.credentialsFromPrivateKey(privateKey);
  myAddress = await credentials.extractAddress();
}

// ----------------------------- Fetching Contact Address ----------------------------- //
Future<void> getDeployedContract(String fileName) async {
  String abiString = await rootBundle.loadString('contract/$fileName');
  var abiJson = jsonDecode(abiString);
  abi = jsonEncode(abiJson['abi']);
  // Get the contract address from the deployed contract
  contractAddress =
      EthereumAddress.fromHex(abiJson['networks']['4']['address']);
}

// ----------------------------- Fetching Contact Functions ----------------------------- //
Future<void> getContractFunctions() async {
  contract =
      DeployedContract(ContractAbi.fromJson(abi, "vivo"), contractAddress);

  /// Intialize contract functions
  totalRegistered = contract.function('totalRegistered');
  vivophones = contract.function('vivophones');
  registerPhone = contract.function('registerPhone');
  updateEntry = contract.function('updateEntry');
}

// ----------------------------- Reading Functions ----------------------------- //
Future<List<dynamic>> readContract(ContractFunction functionName,
    List<dynamic> functionArgs, DeployedContract contract) async {
  var queryResult = await ethClient.call(
    contract: contract,
    function: functionName,
    params: functionArgs,
  );
  return queryResult;
}

// ----------------------------- Writing Functions ----------------------------- //
Future<String> writeContract(ContractFunction functionName,
    List<dynamic> functionArgs, DeployedContract contract) async {
  print(functionArgs);
  var res = await ethClient.sendTransaction(
    credentials,
    Transaction.callContract(
      contract: contract,
      function: functionName,
      parameters: functionArgs,
    ),
    chainId: 4,
  );
  return res;
}
