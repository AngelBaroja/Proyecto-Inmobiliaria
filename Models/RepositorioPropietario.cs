using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;


namespace Proyecto_Inmobiliaria.Models
{
    public class RepositorioPropietario : RepositorioBase
    {
        public RepositorioPropietario(IConfiguration configuration) : base(configuration)
        {
        }

        public int Alta(Propietario p)
        {
            int res = -1;
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = @"INSERT INTO propietarios 
                (nombre, apellido, DNI, telefono, email, estado)
                VALUES (@nombre, @apellido, @dni, @telefono, @email, @estado);
                SELECT LAST_INSERT_ID();"; // devuelve el id insertado
                using (MySqlCommand command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@nombre", p.Nombre);
                    command.Parameters.AddWithValue("@apellido", p.Apellido);
                    command.Parameters.AddWithValue("@dni", p.Dni);
                    command.Parameters.AddWithValue("@telefono", p.Telefono);
                    command.Parameters.AddWithValue("@email", p.Email);
                    command.Parameters.AddWithValue("@estado", p.Estado);
                    connection.Open();
                    res = Convert.ToInt32(command.ExecuteScalar());
                    p.Id = res;
                    connection.Close();
                }
            }
            return res;
        }

        public bool Baja(int id)
        {
            bool res = false;
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = "DELETE FROM propietarios WHERE id = @id";
                using (MySqlCommand command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@id", id);
                    connection.Open();
                    res = command.ExecuteNonQuery() > 0;
                    connection.Close();
                }
            }
            return res;
        }

        public bool BajaLogica(int id)
        {
            bool res = false;
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = "UPDATE propietarios SET estado = @estado WHERE id = @id";
                using (MySqlCommand command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@id", id);
                    command.Parameters.AddWithValue("@estado", false);
                    connection.Open();
                    res = command.ExecuteNonQuery() > 0;
                    connection.Close();
                }
            }
            return res;
        }

        public bool Actualizar(Propietario p)
        {
            bool res = false;
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = @"UPDATE propietarios 
                    SET nombre = @nombre, apellido = @apellido, DNI = @dni, telefono = @telefono, email = @email, estado = @estado 
                    WHERE id = @id";
                using (MySqlCommand command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@id", p.Id);
                    command.Parameters.AddWithValue("@nombre", p.Nombre);
                    command.Parameters.AddWithValue("@apellido", p.Apellido);
                    command.Parameters.AddWithValue("@dni", p.Dni);
                    command.Parameters.AddWithValue("@telefono", p.Telefono);
                    command.Parameters.AddWithValue("@email", p.Email);
                    command.Parameters.AddWithValue("@estado", p.Estado);
                    connection.Open();
                    res = command.ExecuteNonQuery() > 0;
                    connection.Close();
                }
            }
            return res;
        }

        public IList<Propietario> ObtenerTodos()
        {
            var propietarios = new List<Propietario>();
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = "SELECT * FROM propietarios";
                using (MySqlCommand command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    connection.Open();
                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var propietario = new Propietario
                            {
                                Id = reader.GetInt32("id"),
                                Nombre = reader.GetString("nombre"),
                                Apellido = reader.GetString("apellido"),
                                Dni = reader.GetInt32("DNI"),
                                Telefono = reader.IsDBNull(reader.GetOrdinal("telefono")) ? null : reader.GetString("telefono"),
                                Email = reader.GetString("email"),
                                Estado = reader.GetBoolean("estado")
                            };
                            propietarios.Add(propietario);
                        }
                    }
                    connection.Close();
                }
            }
            return propietarios;
        }

        public int ObtenerCantidad()
        {
            int res = 0;
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = @$"
					SELECT COUNT(id)
					FROM Propietarios
				";
                using (MySqlCommand command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    connection.Open();
                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            res = reader.GetInt32(0);
                        }
                    }
                    connection.Close();
                }
            }
            return res;
        }

        public Propietario ObtenerPorId(int id)
        {
            Propietario propietario = null;
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = "SELECT * FROM propietarios WHERE id = @id";
                using (MySqlCommand command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@id", id);
                    connection.Open();
                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            propietario = new Propietario
                            {
                                Id = reader.GetInt32("id"),
                                Nombre = reader.GetString("nombre"),
                                Apellido = reader.GetString("apellido"),
                                Dni = reader.GetInt32("DNI"),
                                Telefono = reader.IsDBNull(reader.GetOrdinal("telefono")) ? null : reader.GetString("telefono"),
                                Email = reader.GetString("email"),
                                Estado = reader.GetBoolean("estado")
                            };
                        }
                    }
                    connection.Close();
                }
            }
            return propietario;
        }
        
        public IList<Propietario> BuscarPorNombre(string nombre)
		{
			List<Propietario> res = new List<Propietario>();
			Propietario p = null;
			nombre = "%" + nombre + "%";
			using (MySqlConnection connection = new MySqlConnection(connectionString))
			{
				string sql = @"SELECT id, nombre, apellido, DNI, telefono, email, estado 
					FROM Propietarios
					WHERE nombre LIKE @nombre OR apellido LIKE @nombre";
				using (MySqlCommand command = new MySqlCommand(sql, connection))
				{
                    command.Parameters.AddWithValue("@nombre", nombre);
					command.CommandType = CommandType.Text;
					connection.Open();
					var reader = command.ExecuteReader();
					while (reader.Read())
					{
						p = new Propietario
						{
							Id = reader.GetInt32("id"),
							Nombre = reader.GetString("nombre"),
							Apellido = reader.GetString("apellido"),
							Dni = reader.GetInt32("DNI"),
							Telefono = reader.GetString("telefono"),
							Email = reader.GetString("email"),
							Estado = reader.GetBoolean("estado"),
						};
						res.Add(p);
					}
					connection.Close();
				}
			}
			return res;
		}

        
    }
}
