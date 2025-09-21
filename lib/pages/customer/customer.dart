import 'package:flutter/material.dart';
import '../../widgets/appbar.dart';

class Client {
  final String idUser;
  final String name;
  final String surname;
  final String address;
  final String status;
  final String photo;

  Client({
    required this.idUser,
    required this.name,
    required this.surname,
    required this.address,
    required this.status,
    required this.photo,
  });
}

class ClientsManagementScreen extends StatefulWidget {
  const ClientsManagementScreen({super.key});

  @override
  State<ClientsManagementScreen> createState() =>
      _ClientsManagementScreenState();
}

class _ClientsManagementScreenState extends State<ClientsManagementScreen> {
  final List<Client> _clients = [
    Client(
      idUser: '1',
      name: 'Juan',
      surname: 'Pérez',
      address: 'Calle Principal 123',
      status: 'Activo',
      photo: 'assets/img/clients/client1.jpg',
    ),
    Client(
      idUser: '2',
      name: 'María',
      surname: 'González',
      address: 'Avenida Central 456',
      status: 'Inactivo',
      photo: 'assets/img/clients/client2.jpg',
    ),
  ];

  void _addClient() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ClientFormScreen()),
    ).then((newClient) {
      if (newClient != null) {
        setState(() {
          _clients.add(Client(
            idUser: DateTime.now().millisecondsSinceEpoch.toString(),
            name: newClient['name'],
            surname: newClient['surname'],
            address: newClient['address'],
            status: newClient['status'],
            photo: newClient['photo'] ?? 'assets/img/clients/default.jpg',
          ));
        });
      }
    });
  }

  void _editClient(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientFormScreen(client: _clients[index]),
      ),
    ).then((editedClient) {
      if (editedClient != null) {
        setState(() {
          _clients[index] = Client(
            idUser: _clients[index].idUser,
            name: editedClient['name'],
            surname: editedClient['surname'],
            address: editedClient['address'],
            status: editedClient['status'],
            photo: editedClient['photo'] ?? _clients[index].photo,
          );
        });
      }
    });
  }

  void _deleteClient(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content:
              const Text('¿Está seguro de que desea eliminar este cliente?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _clients.removeAt(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cliente eliminado')),
                );
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cliente'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: _addClient,
            tooltip: 'Agregar información',
          ),
        ],
      ),
      body: _clients.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.people_outline,
                      size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No hay clientes registrados'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _addClient,
                    child: const Text('Agregar primer cliente'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _clients.length,
              itemBuilder: (context, index) {
                return _buildClientCard(_clients[index], index);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addClient,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildClientCard(Client client, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(client.photo),
                  onBackgroundImageError: (exception, stackTrace) =>
                      const Icon(Icons.person, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${client.name} ${client.surname}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        client.address,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: client.status == 'Activo'
                                ? Colors.green
                                : Colors.red,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(client.status),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _editClient(index),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Editar'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => _deleteClient(index),
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Eliminar'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ClientFormScreen extends StatefulWidget {
  final Client? client;

  const ClientFormScreen({super.key, this.client});

  @override
  State<ClientFormScreen> createState() => _ClientFormScreenState();
}

class _ClientFormScreenState extends State<ClientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final List<String> _estados = ['Activo', 'Inactivo'];
  String? _estadoSeleccionado;
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      _nameController.text = widget.client!.name;
      _surnameController.text = widget.client!.surname;
      _addressController.text = widget.client!.address;
      _estadoSeleccionado = widget.client!.status;
      _photoPath = widget.client!.photo;
    }
  }

  void _saveClient() {
    if (_formKey.currentState!.validate()) {
      if (_estadoSeleccionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor seleccione un estado')),
        );
        return;
      }

      final clientData = {
        'name': _nameController.text,
        'surname': _surnameController.text,
        'address': _addressController.text,
        'status': _estadoSeleccionado,
        'photo': _photoPath ?? 'assets/img/clients/default.jpg',
      };

      Navigator.pop(context, clientData);
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _selectPhoto() {
    // En una implementación real, aquí se abriría el selector de imágenes
    // Por ahora, simulamos la selección de una foto
    setState(() {
      _photoPath = 'assets/img/clients/new_client.jpg';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Foto seleccionada (simulación)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.client == null ? 'Agregar Cliente' : 'Editar Cliente',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _selectPhoto,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      _photoPath ?? 'assets/img/clients/default.jpg'),
                  onBackgroundImageError: (exception, stackTrace) =>
                      const Icon(Icons.person, size: 50),
                  child: _photoPath == null
                      ? const Icon(Icons.camera_alt, size: 30)
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Toca para seleccionar foto',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(
                  labelText: 'Apellido',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el apellido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la dirección';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _estadoSeleccionado,
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  prefixIcon: Icon(Icons.toggle_on),
                  border: OutlineInputBorder(),
                ),
                items: _estados.map((String estado) {
                  return DropdownMenuItem<String>(
                    value: estado,
                    child: Text(estado),
                  );
                }).toList(),
                onChanged: (String? nuevoValor) {
                  setState(() {
                    _estadoSeleccionado = nuevoValor;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor seleccione un estado';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveClient,
                      child:
                          Text(widget.client == null ? 'Agregar' : 'Guardar'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _cancel,
                      child: const Text('Cancelar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
