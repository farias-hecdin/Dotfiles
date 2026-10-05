import React, { useState, useEffect, useCallback } from "react";

interface UserProfile {
  id: number;
  name: string;
  email: string;
  isActive: boolean;
  roles: ("admin" | "editor" | "viewer")[];
}

interface Props {
  userId: number;
  onUpdate?: (profile: UserProfile) => void;
}

export const UserCard: React.FC<Props> = ({ userId, onUpdate }) => {
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const [loading, setLoading] = useState(false);

  const fetchUser = useCallback(async () => {
    setLoading(true);
    try {
      const res = await fetch(`/api/users/${userId}`);
      const data: UserProfile = await res.json();
      setProfile(data);
      onUpdate?.(data);
    } catch (err) {
      console.error("Failed to fetch user:", err);
    } finally {
      setLoading(false);
    }
  }, [userId, onUpdate]);

  useEffect(() => {
    fetchUser();
  }, [fetchUser]);

  if (loading) return <div className="spinner">Cargando...</div>;
  if (!profile) return null;

  return (
    <article className={`user-card ${profile.isActive ? "active" : "inactive"}`}>
      <header>
        <h2>{profile.name}</h2>
        <span className="badge">{profile.roles.join(", ")}</span>
      </header>
      <p>{profile.email}</p>
      <button onClick={() => setProfile(null)}>Limpiar</button>
    </article>
  );
};

export default UserCard;

