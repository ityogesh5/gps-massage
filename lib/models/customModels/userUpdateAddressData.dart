class Customer {
  String addressKey;
  String address;
  String latLong;
  String addressType;

  Customer(this.addressKey, this.address,this.latLong,this.addressType);

  @override
  String toString() {
    return '{ ${this.addressKey} : ${this.address} , ${this.latLong} , addressType : ${this.addressType} }';
  }
}
