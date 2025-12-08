import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';

class BranchModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String country;
  final String state;
  final String city;
  final String? zipCode;
  final bool isPrimary;
  final bool isShippingLocation;
  final String createdAt;
  final String updatedAt;

  const BranchModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    this.zipCode,
    required this.isPrimary,
    required this.isShippingLocation,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: validateString(json['id'].toString()),
      name: validateString(json['name']),
      email: validateString(json['email']),
      phone: validateString(json['phone']),
      address: validateString(json['address']),
      country: validateString(json['country']),
      state: validateString(json['state']),
      city: validateString(json['city']),
      zipCode: json['zip_code'] != null ? validateString(json['zip_code']) : null,
      isPrimary: json['is_primary'] == 0 ? false : true,
      isShippingLocation: json['is_shipping_location'] == 0 ? false : true,
      createdAt: validateString(json['created_at']),
      updatedAt: validateString(json['updated_at']),
    );
  }

  //make toJson
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'country': country,
        'state': state,
        'city': city,
        'zip_code': zipCode,
        'is_primary': isPrimary,
        'is_shipping_location': isShippingLocation,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        address,
        country,
        state,
        city,
        zipCode,
        isPrimary,
        isShippingLocation,
        createdAt,
        updatedAt,
      ];
}

final demoBranches = [
  BranchModel(
    id: '1',
    name: 'Branch 1',
    email: 'branch1@example.com',
    phone: '1234567890',
    address: 'Address 1',
    country: 'Country 1',
    state: 'State 1',
    city: 'Al Ain',
    zipCode: '00001',
    isPrimary: true,
    isShippingLocation: false,
    createdAt: '2023-12-01T00:00:00.000Z',
    updatedAt: '2023-12-01T00:00:00.000Z',
  ),
  BranchModel(
    id: '2',
    name: 'Branch 2',
    email: 'branch2@example.com',
    phone: '1234567891',
    address: 'Address 2',
    country: 'Country 2',
    state: 'State 2',
    city: 'Sharjah',
    zipCode: '00002',
    isPrimary: false,
    isShippingLocation: true,
    createdAt: '2023-12-02T00:00:00.000Z',
    updatedAt: '2023-12-02T00:00:00.000Z',
  ),
  BranchModel(
    id: '3',
    name: 'Branch 3',
    email: 'branch3@example.com',
    phone: '1234567892',
    address: 'Address 3',
    country: 'Country 3',
    state: 'State 3',
    city: 'Sharjah',
    zipCode: '00003',
    isPrimary: false,
    isShippingLocation: false,
    createdAt: '2023-12-03T00:00:00.000Z',
    updatedAt: '2023-12-03T00:00:00.000Z',
  ),
  BranchModel(
    id: '4',
    name: 'Branch 4',
    email: 'branch4@example.com',
    phone: '1234567893',
    address: 'Address 4',
    country: 'Country 4',
    state: 'State 4',
    city: 'Abu Dhabi',
    zipCode: '00004',
    isPrimary: true,
    isShippingLocation: true,
    createdAt: '2023-12-04T00:00:00.000Z',
    updatedAt: '2023-12-04T00:00:00.000Z',
  ),
  BranchModel(
    id: '5',
    name: 'Branch 5',
    email: 'branch5@example.com',
    phone: '1234567894',
    address: 'Address 5',
    country: 'Country 5',
    state: 'State 5',
    city: 'Abu Dhabi',
    zipCode: '00005',
    isPrimary: false,
    isShippingLocation: false,
    createdAt: '2023-12-05T00:00:00.000Z',
    updatedAt: '2023-12-05T00:00:00.000Z',
  ),
  BranchModel(
    id: '6',
    name: 'Branch 6',
    email: 'branch6@example.com',
    phone: '1234567895',
    address: 'Address 6',
    country: 'Country 6',
    state: 'State 6',
    city: 'Sharjah',
    zipCode: '00006',
    isPrimary: false,
    isShippingLocation: true,
    createdAt: '2023-12-06T00:00:00.000Z',
    updatedAt: '2023-12-06T00:00:00.000Z',
  ),
];
