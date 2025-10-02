using System.Data;
using MySql.Data.MySqlClient;


namespace Proyecto_Inmobiliaria.Models
{
    public class RepositorioUsuario : RepositorioBase, IRepositorioUsuario
    {
        public RepositorioUsuario(IConfiguration configuration) : base(configuration)
        {

        }

        public int Alta(Usuario e)
        {
            int res = -1;
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = @"INSERT INTO Usuarios 
					(Nombre, Apellido, Avatar, Email, Clave, Rol) 
					VALUES (@nombre, @apellido, @avatar, @email, @clave, @rol);
					SELECT LAST_INSERT_ID();";
                using (var command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@nombre", e.Nombre);
                    command.Parameters.AddWithValue("@apellido", e.Apellido);
                    if (String.IsNullOrEmpty(e.Avatar))
                        command.Parameters.AddWithValue("@avatar", /*DBNull.Value*/"");
                    else
                        command.Parameters.AddWithValue("@avatar", e.Avatar);
                    command.Parameters.AddWithValue("@email", e.Email);
                    command.Parameters.AddWithValue("@clave", e.Clave);
                    command.Parameters.AddWithValue("@rol", e.Rol);
                    connection.Open();
                    res = Convert.ToInt32(command.ExecuteScalar());
                    e.id = res;
                    connection.Close();
                }
            }
            return res;
        }
        public int Baja(int id)
        {
            int res = -1;
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = "DELETE FROM Usuarios WHERE id = @id";
                using (var command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@id", id);
                    connection.Open();
                    res = command.ExecuteNonQuery();
                    connection.Close();
                }
            }
            return res;
        }
        public int Modificacion(Usuario e)
        {
            int res = -1;
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = @"UPDATE Usuarios 
					SET Nombre=@nombre, Apellido=@apellido, Avatar=@avatar, Email=@email, Clave=@clave, Rol=@rol
					WHERE Id = @id";
                using (var command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@nombre", e.Nombre);
                    command.Parameters.AddWithValue("@apellido", e.Apellido);
                    command.Parameters.AddWithValue("@avatar", e.Avatar);
                    command.Parameters.AddWithValue("@email", e.Email);
                    command.Parameters.AddWithValue("@clave", e.Clave);
                    command.Parameters.AddWithValue("@rol", e.Rol);
                    command.Parameters.AddWithValue("@id", e.id);
                    connection.Open();
                    res = command.ExecuteNonQuery();
                    connection.Close();
                }
            }
            return res;
        }

        public IList<Usuario> ObtenerTodos()
        {
            IList<Usuario> res = new List<Usuario>();
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = @"
					SELECT Id, Nombre, Apellido, Avatar, Email, Clave, Rol
					FROM Usuarios";
                using (var command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    connection.Open();
                    var reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        Usuario e = new Usuario
                        {
                            id = reader.GetInt32("id"),
                            Nombre = reader.GetString("Nombre"),
                            Apellido = reader.GetString("Apellido"),
                            Avatar = reader.GetString("Avatar"),
                            Email = reader.GetString("Email"),
                            Clave = reader.GetString("Clave"),
                            Rol = reader.GetInt32("Rol"),
                        };
                        res.Add(e);
                    }
                    connection.Close();
                }
            }
            return res;
        }

        public Usuario ObtenerPorId(int id)
        {
            Usuario? e = null;
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = @"SELECT 
					Id, Nombre, Apellido, Avatar, Email, Clave, Rol 
					FROM Usuarios
					WHERE Id=@id";
                using (var command = new MySqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@id", id);
                    command.CommandType = CommandType.Text;
                    connection.Open();
                    var reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        e = new Usuario
                        {
                            id = reader.GetInt32("id"),
                            Nombre = reader.GetString("Nombre"),
                            Apellido = reader.GetString("Apellido"),
                            Avatar = reader.GetString("Avatar"),
                            Email = reader.GetString("Email"),
                            Clave = reader.GetString("Clave"),
                            Rol = reader.GetInt32("Rol"),
                        };
                    }
                    connection.Close();
                }
            }
            return e;
        }

        public Usuario ObtenerPorEmail(string email)
        {
            Usuario? e = null;
            using (MySqlConnection connection = new MySqlConnection(connectionString))
            {
                string sql = @"SELECT
					Id, Nombre, Apellido, Avatar, Email, Clave, Rol FROM Usuarios
					WHERE Email=@email";
                using (var command = new MySqlCommand(sql, connection))
                {
                    command.CommandType = CommandType.Text;
                    command.Parameters.AddWithValue("@email", email);
                    connection.Open();
                    var reader = command.ExecuteReader();
                    if (reader.Read())
                    {
                        e = new Usuario
                        {
                            id = reader.GetInt32("id"),
                            Nombre = reader.GetString("Nombre"),
                            Apellido = reader.GetString("Apellido"),
                            Avatar = reader.GetString("Avatar"),
                            Email = reader.GetString("Email"),
                            Clave = reader.GetString("Clave"),
                            Rol = reader.GetInt32("Rol"),
                        };
                    }
                    connection.Close();
                }
            }
            return e;
        }
        public int ObtenerCantidad()
		{
			int res = 0;
			using (MySqlConnection connection = new MySqlConnection(connectionString))
			{
				string sql = @$"
					SELECT COUNT(id)
					FROM usuarios
				";
				using (var command = new MySqlCommand(sql, connection))
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
	}
}