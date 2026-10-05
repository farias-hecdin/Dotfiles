import { useState, useMemo } from "react";

function TodoList({ initialTodos = [], filter = "all" }) {
  const [todos, setTodos] = useState(initialTodos);
  const [input, setInput] = useState("");

  const filtered = useMemo(() => {
    return todos.filter((t) => {
      if (filter === "active") return !t.done;
      if (filter === "completed") return t.done;
      return true;
    });
  }, [todos, filter]);

  const addTodo = (e) => {
    e.preventDefault();
    if (!input.trim()) return;
    setTodos((prev) => [
      ...prev,
      { id: Date.now(), text: input, done: false },
    ]);
    setInput("");
  };

  const toggle = (id) => {
    setTodos((prev) =>
      prev.map((t) => (t.id === id ? { ...t, done: !t.done } : t))
    );
  };

  return (
    <section className="todo-list">
      <form onSubmit={addTodo}>
        <input
          value={input}
          onChange={(e) => setInput(e.target.value)}
          placeholder="Nueva tarea..."
        />
        <button type="submit">Agregar</button>
      </form>
      <ul>
        {filtered.map((todo) => (
          <li key={todo.id} className={todo.done ? "done" : ""}>
            <label>
              <input
                type="checkbox"
                checked={todo.done}
                onChange={() => toggle(todo.id)}
              />
              {todo.text}
            </label>
          </li>
        ))}
      </ul>
    </section>
  );
}

export default TodoList;

